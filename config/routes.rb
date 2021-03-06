Rails.application.routes.draw do
  
  resources :matches

  get "/players", to: "players#index", as: :all_players
  get "/players/:username", to: "players#show", as: :get_player
  
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "callbacks"}
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end
  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  scope '/api' do
    post '/ping/:game/matches', to: 'api#pingMatch'
  end

  root to: "home#index"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# == Route Map
#
#                                Prefix Verb     URI Pattern                                                                              Controller#Action
#                               matches GET      /matches(.:format)                                                                       matches#index
#                                       POST     /matches(.:format)                                                                       matches#create
#                             new_match GET      /matches/new(.:format)                                                                   matches#new
#                            edit_match GET      /matches/:id/edit(.:format)                                                              matches#edit
#                                 match GET      /matches/:id(.:format)                                                                   matches#show
#                                       PATCH    /matches/:id(.:format)                                                                   matches#update
#                                       PUT      /matches/:id(.:format)                                                                   matches#update
#                                       DELETE   /matches/:id(.:format)                                                                   matches#destroy
#                           all_players GET      /players(.:format)                                                                       players#index
#                            get_player GET      /players/:username(.:format)                                                             players#show
#                      new_user_session GET      /users/sign_in(.:format)                                                                 devise/sessions#new
#                          user_session POST     /users/sign_in(.:format)                                                                 devise/sessions#create
#                  destroy_user_session DELETE   /users/sign_out(.:format)                                                                devise/sessions#destroy
#          user_bnet_omniauth_authorize GET|POST /users/auth/bnet(.:format)                                                               callbacks#passthru
#           user_bnet_omniauth_callback GET|POST /users/auth/bnet/callback(.:format)                                                      callbacks#bnet
#                     new_user_password GET      /users/password/new(.:format)                                                            devise/passwords#new
#                    edit_user_password GET      /users/password/edit(.:format)                                                           devise/passwords#edit
#                         user_password PATCH    /users/password(.:format)                                                                devise/passwords#update
#                                       PUT      /users/password(.:format)                                                                devise/passwords#update
#                                       POST     /users/password(.:format)                                                                devise/passwords#create
#              cancel_user_registration GET      /users/cancel(.:format)                                                                  registrations#cancel
#                 new_user_registration GET      /users/sign_up(.:format)                                                                 registrations#new
#                edit_user_registration GET      /users/edit(.:format)                                                                    registrations#edit
#                     user_registration PATCH    /users(.:format)                                                                         registrations#update
#                                       PUT      /users(.:format)                                                                         registrations#update
#                                       DELETE   /users(.:format)                                                                         registrations#destroy
#                                       POST     /users(.:format)                                                                         registrations#create
#                                 login GET      /login(.:format)                                                                         devise/sessions#new
#                                signup GET      /signup(.:format)                                                                        devise/registrations#new
#                                       POST     /api/ping/:game/matches(.:format)                                                        api#pingMatch
#                                  root GET      /                                                                                        home#index
#                           sidekiq_web          /sidekiq                                                                                 Sidekiq::Web
#         rails_mandrill_inbound_emails POST     /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#         rails_postmark_inbound_emails POST     /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST     /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST     /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#          rails_mailgun_inbound_emails POST     /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET      /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST     /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET      /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET      /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET      /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT      /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE   /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST     /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET      /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET      /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET      /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT      /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST     /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
