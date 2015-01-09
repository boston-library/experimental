require "om"
class Datastreams::ItemMetadata < ActiveFedora::OmDatastream
	include OM::XML::Document

  set_terminology do |t|
    t.root(path: "mods", :xmlns=>"http://www.loc.gov/mods/v3")
    t.title_info(path: "titleInfo") {
    	t.title(path: "title")
    	t.sub_title(path: "subTitle")
    	t.part_number(path: "partNumber")
    	t.part_name(path: "partName")
    	t.non_sort(path: "nonSort")
    }
    t.name(path: "name") {
    	t.name_part(path: "namePart")
    	t.affiliation(path: "affiliation")
    	t.role(path: "role") {
    		t.role_term(path: "roleTerm")
    	}
    }
    t.type_of_resource(path: "typeOfResource")
    t.genre(path: "genre")
    t.origin_info(path: "originInfo") {
    	t.place(path: "place") {
    		t.place_term(path: "placeTerm")
    	}
    	t.publisher(path: "publisher")
    	t.date_issued(path: "dateIssued")
    	t.date_created(path: "dateCreated")
    	t.copyright_date(path: "copyrightDate")
    	t.date_other(path: "dateOther")
    	t.edition(path: "edition")
    	t.issuance(path: "issuance")
    	t.frequency(path: "frequency")
    }
    t.language(path: "language") {
    	t.language_term(path: "languageTerm")
    }
    t.physical_description(path: "physicalDescription") {
    	t.internet_media_type(path: "internetMediaType")
    	t.extent(path: "extent")
    	t.digital_origin(path: "digitalOrigin")
    	t.note(path: "note")
    }
    t.abstract(path: "abstract")
    t.table_of_contents(path: "tableOfContents")
    t.note(path: "note")
    t.subject(path: "subject") {
    	t.topic(path: "topic")
    	t.geographic(path: "geographic")
    	t.temporal(path: "temporal")
    	t.title_info(path: "titleInfo")
    	t.name(path: "name") {
    		t.name_part(path: "namePart")
    		t.affiliation(path: "affiliation")
    	}
    	t.genre(path: "genre")
    	t.hierarchical_geographic(path: "hierarchicalGeographic") {
    		t.continent(path: "continent")
    		t.country(path: "country")
    		t.province(path: "province")
    		t.region(path: "region")
    		t.state(path: "state")
    		t.territory(path: "territory")
    		t.county(path: "county")
    		t.city(path: "city")
    		t.city_section(path: "citySection")
    		t.island(path: "island")
    		t.area(path: "area")
    		t.extraterrestrial_area(path: "extraterrestrialArea")
    	}
    	t.cartographics(path: "cartographics") {
    		t.coordinates(path: "coordinates")
    		t.scale(path: "scale")
    		t.projection(path: "projection")
    	}
    }
    t.related_item(path: "relatedItem")
    t.identifier(path: "identifier")
    t.location(path: "location") {
    	t.physical_location(path: "physicalLocation")
    	t.url(path: "url")
    	t.holding_simple(path: "holdingSimple") {
    		t.copy_information(path: "copyInformation") {
    			t.sub_location(path: "subLocation")
    			t.shelf_locator(path: "shelfLocator")
    			t.enumeration_and_chronology(path: "enumerationAndChronology")
    		}
    	}
    }
    t.access_condition(path: "accessCondition")
    t.record_info(path: "recordInfo") {
    	t.record_content_source(path: "recordContentSource")
    	t.record_origin(path: "recordOrigin")
    	t.language_of_cataloging(path: "languageOfCataloging") {
    		t.language_term(path: "languageTerm")
    	}
    	t.description_standard(path: "descriptionStandard")
    }
  end

  def self.xml_template
    Nokogiri::XML.parse('<mods xmlns="http://www.loc.gov/mods/v3"/>')
  end

  def insert_title(nonSort=nil, main_title=nil, subtitle=nil)
    title_index = self.mods(0).title_info.count
    self.mods(0).title_info(title_index).non_sort = nonSort unless nonSort.blank?
    self.mods(0).title_info(title_index).title = main_title unless main_title.blank?

    self.mods(0).title_info(title_index).sub_title = subtitle unless subtitle.blank?

  end


  def prefix
    # set a datastream prefix if you need to namespace terms that might occur in multiple data streams 
    ""
  end

end