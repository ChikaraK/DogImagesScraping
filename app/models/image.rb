class Image < ApplicationRecord
	has_many:confidence_tag, dependent: :destroy
end
