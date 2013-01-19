# Other authorizers should subclass this one
class BundleAuthorizer < ApplicationAuthorizer
  def updatable_by? user
    return false unless user.present?

    resource.user == user
  end
end
