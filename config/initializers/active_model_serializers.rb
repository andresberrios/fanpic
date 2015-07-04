# This disables the root element in JSON views *globally*.
# See https://github.com/rails-api/active_model_serializers#disabling-the-root-element.

# Disable for all serializers (except ArraySerializer)
ActiveModel::Serializer.root = false

# Disable for ArraySerializer
ActiveModel::ArraySerializer.root = false
