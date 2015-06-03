class Item < ActiveFedora::Base
  has_metadata 'descMetadata', type: Datastreams::ItemMetadata

=begin
  def assert_content_model
    model_list = [self.class.to_s]

    object_superclass = self.class.superclass
    until object_superclass == ActiveFedora::Base || object_superclass == Object do
      model_list << object_superclass.to_s
      object_superclass = object_superclass.superclass
    end

    self.has_model = model_list
  end
=end
end