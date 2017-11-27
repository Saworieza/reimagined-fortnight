PublicActivity::Activity.class_eval do
  acts_as_readable :on => :created_at

  # def self.policy_class
  #   ActivityPolicy
  # end
end