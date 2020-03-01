Rails.application.routes.draw do

  get 'user/new'

  match 'upload_file',                             to: 'user#upload_file', via: [:post]

end
