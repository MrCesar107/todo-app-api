# frozen_string_literal: true

class LabelTask < ApplicationRecord
  belongs_to :label
  belongs_to :task
end
