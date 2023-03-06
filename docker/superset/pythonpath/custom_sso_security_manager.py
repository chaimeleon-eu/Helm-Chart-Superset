from flask_appbuilder.security.views import AuthOAuthView
from flask_appbuilder.security.manager import AUTH_OAUTH
from superset.security import SupersetSecurityManager
from flask_appbuilder.views import expose
from flask import request, redirect, url_for
from flask_login import logout_user
from urllib.parse import quote
import jwt
import logging

# https://docs.authlib.org/en/latest/client/flask.html
# https://github.com/dpgaspar/Flask-AppBuilder/tree/v3.3.0/flask_appbuilder/security

class CustomOAuthView(AuthOAuthView):

  @expose('/login/', methods=['GET', 'POST'])
  def login(self, flag=True):
    provider = self.appbuilder.sm.oauth_providers[0]['name']
    logging.debug("Going to call authorize for: {0}".format(provider))

    state = jwt.encode(
        request.args.to_dict(flat=False),
        self.appbuilder.app.config["SECRET_KEY"],
        algorithm="HS256",
    )

    try:
      return self.appbuilder.sm.oauth_remotes[provider].authorize_redirect(
          redirect_uri=url_for(".oauth_authorized", provider=provider, _external=True),
          state=state.decode("ascii") if isinstance(state, bytes) else state
      )
    except Exception as e:
      logging.error("Error on OAuth authorize: {0}".format(e))
      return redirect(self.appbuilder.get_url_for_index)

  @expose('/logout/', methods=['GET', 'POST'])
  def logout(self):
    logout_user()

    provider = self.appbuilder.sm.oauth_providers[0]['name']
    metadata = self.appbuilder.sm.oauth_remotes[provider].load_server_metadata()
    logout_url = metadata['end_session_endpoint']
    redirect_url = request.url_root.strip('/') + self.appbuilder.get_url_for_index
    logging.debug("Logout URL: {0} - Redirect URL: {1}".format(logout_url, redirect_url))

    return redirect(logout_url +'?redirect_uri=' + quote(redirect_url))

class CustomSsoSecurityManager(SupersetSecurityManager):
  authoauthview = CustomOAuthView
  def __init__(self, appbuilder):
    super(CustomSsoSecurityManager, self).__init__(appbuilder)
  
  def oauth_user_info(self, provider, response=None):
    logging.debug("Received Oauth2 response from provider: {0}.".format(provider))

    me = response['userinfo']
    logging.debug("User info: {0}".format(me))

    roles = me['roles'] if 'roles' in me else []
    logging.info("User roles: {0}".format(roles))

    return {
      'id' : me['sub'],
      'name' : me['name'],
      'email' : me['email'],
      'username' : me['preferred_username'],
      'first_name': me['given_name'],
      'last_name': me['family_name'],
      'role_keys': roles
    }
