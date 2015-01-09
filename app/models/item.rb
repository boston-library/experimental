class Item < ActiveFedora::Base
  has_metadata 'descMetadata', type: Datastreams::ItemMetadata
end