# rorapi
Following below steps to configure rorapi project:

1. Download code in local system with git link:
   https://github.com/930krishna/rorapi.git

2. Import database "rorapidb" in postgresql.

3. Import Postman Collection and Environment.

4. Open terminal and execute below commands:
   mix deps.get 
   mix phx.server
  
   server start in terminal: http://0.0.0.0:4000


Endpoints for manage ROR API's:

login_path  POST    	 /api/admin/login                           RorapiWeb.LoginController :admin_login
     login_path  POST    /api/v1/login                              RorapiWeb.LoginController :user_login
  register_path  POST    /api/v1/register                           RorapiWeb.RegisterController :register
    events_path  GET     /api/admin/event                           RorapiWeb.Admin.EventsController :index
    events_path  GET     /api/admin/event/:id                       RorapiWeb.Admin.EventsController :show
    events_path  POST    /api/admin/event                           RorapiWeb.Admin.EventsController :create
    events_path  PATCH   /api/admin/event/:id                       RorapiWeb.Admin.EventsController :update
                 PUT     /api/admin/event/:id                       RorapiWeb.Admin.EventsController :update
    events_path  DELETE  /api/admin/event/:id                       RorapiWeb.Admin.EventsController :delete
eventusers_path  GET     /api/admin/event/attend_list/:event_id     RorapiWeb.Admin.EventusersController :attend_list
eventusers_path  GET     /api/admin/event/cancelled_list/:event_id  RorapiWeb.Admin.EventusersController :cancelled_list
     users_path  GET     /api/admin/user/list                       RorapiWeb.Admin.UsersController :list
     users_path  POST    /api/admin/user/invite                     RorapiWeb.Admin.UsersController :invite
    events_path  GET     /api/v1/event/list                         RorapiWeb.V1.EventsController :list
    events_path  GET     /api/v1/event/cancel/list                  RorapiWeb.V1.EventsController :cancel_list
    events_path  POST    /api/v1/event/add                          RorapiWeb.V1.EventsController :add
    events_path  POST    /api/v1/event/remove                       RorapiWeb.V1.EventsController :remove
