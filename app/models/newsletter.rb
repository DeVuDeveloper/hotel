# frozen_string_literal: true

class Newsletter < ApplicationRecord
  belongs_to :user
  after_create_commit lambda {
                        broadcast_prepend_to "newsletters", partial: "admin/dashboard/newsletters/newsletter", locals: {newsletter: self},
                          target: "newsletters"
                      }
end
