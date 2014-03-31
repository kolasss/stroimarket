# module BSON
#   class ObjectId
#     alias :to_json :to_s
#     alias :as_json :to_s
#   end
# end

# module Mongoid
#   module Document
#     def as_json(options={})
#       attrs = super(options)
#       attrs["id"] = attrs["_id"]
#       attrs
#     end
#   end
# end
