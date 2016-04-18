module NetSuite
  module Records
    class CalendarEvent
      include Support::Fields
      include Support::RecordRefs
      include Support::Records
      include Support::Actions
      include Namespaces::ActSched   
      
      actions :get, :get_list, :add, :update, :upsert, :upsert_list, :delete, :delete_list, :search
      
      fields :access_level, :all_day_event, :created_date, :end_by_date, :end_date, :last_modified_date, :location, :message, :no_end_date,
        :period, :recurence, :send_email, :series_start_date, :start_date, :timed_event, :title, :status 
      
      field :custom_field_list, CustomFieldList
      
      record_refs :company, :contact, :customForm, :organizer, :owner, :support_case, :transaction 
      
      def initialize(attributes = {})
        @internal_id = attributes.delete(:internal_id) || attributes.delete(:@internal_id)
        @external_id = attributes.delete(:external_id) || attributes.delete(:@external_id)
        initialize_from_attributes_hash(attributes)
      end

      def to_record
        rec = super
        if rec["#{record_namespace}:customFieldList"]
          rec["#{record_namespace}:customFieldList!"] = rec.delete("#{record_namespace}:customFieldList")
        end
        rec
      end      
      
    end
  end
end
