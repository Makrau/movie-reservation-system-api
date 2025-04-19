module Admin
  class BaseController < ApplicationController
    include AdminAuthenticatable
  end
end
