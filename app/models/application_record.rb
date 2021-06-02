class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


def user_name
 username.titleize
end

end
