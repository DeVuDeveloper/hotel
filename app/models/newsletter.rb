class Newsletter < ApplicationRecord
  belongs_to :user
  after_create_commit -> { broadcast_prepend_to "newsletters", partial: "admin/dashboard/newsletters/newsletter", locals: { newsletter: self }, target: "newsletters" }
end
