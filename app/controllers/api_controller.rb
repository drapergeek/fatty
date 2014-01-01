class ApiController < ApplicationController
  skip_before_filter :authorize
end
