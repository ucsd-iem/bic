# RailsAdmin config file. Generated on October 04, 2012 16:15
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|


  ################  Global configuration  ################

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['UST-UCSD Symposium', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_user } # auto-generated
  config.authenticate_with do
    warden.authenticate! :scope => :user
  end

  # If you want to track changes on your models:
  # config.audit_with :history, 'User'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'User'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = ['User']

  # Include specific models (exclude the others):
  # config.included_models = ['User']

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block
  
  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.


  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:
  
  ###  User  ###
  
  config.model 'Abstract' do
    edit do
      field :title
      field :authors
      field :affiliations
      field :keyword_list
      field :body
      field :year
      field :position
      field :email
      field :event do
        nested_form false
      end
    end
    
    list do
 #     field :dynamic_title do
#        label "Title"
#      end
      sort_by :position
    end
    
#    object_label_method do
#      :dynamic_title
#    end
  end # config.model 'Abstract'

  config.model 'Event' do
    edit do
      field :title, :text
      field :start do
        default_value do
          DateTime.new(2013,6,19,12,00)
        end
      end
      field :stop do
        default_value do
          Time.now
        end
      end
      field :location

#      field :abstracts do
#        nested_form false
#      end
#      field :moderators do
#        nested_form false
#      end    
    end

    list do
      field :dynamic_title do
        label "Title"
      end

      sort_by :start
      sort_reverse false
    end

    object_label_method do
      :dynamic_title
    end
  end
    
  config.model 'Moderator' do
    object_label_method do
      :name
    end
    field :first_name
    field :middle_name
    field :last_name
    field :affiliaiton
    field :biosketch
    field :photo

#    field :event do
 #     nested_form false
  #  end
  end
    
    
  config.model 'Sponsor' do
    edit do
      field :name
      field :url
      field :level, :enum do
        enum do
          %w{ Dinner\ Sponsor Foundational Supporting }
        end
      end
      field :logo
      field :tagline do
        html_attributes rows: 2
      end
      field :mission_statement do
        html_attributes rows: 6
#        ckeditor true
      end
      include_all_fields
    end
  end    
    
  # config.model 'User' do

  #   # You can copy this to a 'rails_admin do ... end' block inside your user.rb model definition
  
  #   # Found associations:

  #   # Found columns:

  #     configure :id, :integer 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 

  #   # Cross-section configuration:
  
  #     # object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #     # label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #     # label_plural 'My models'      # Same, plural
  #     # weight 0                      # Navigation priority. Bigger is higher.
  #     # parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #     # navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  
  #   # Section specific configuration:
  
  #     list do
  #       # filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #       # items_per_page 100    # Override default_items_per_page
  #       # sort_by :id           # Sort column (default is primary key)
  #       # sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     end
  #     show do; end
  #     edit do; end
  #     export do; end
  #     # also see the create, update, modal and nested sections, which override edit in specific cases (resp. when creating, updating, modifying from another model in a popup modal or modifying from another model nested form)
  #     # you can override a cross-section field configuration in any section with the same syntax `configure :field_name do ... end`
  #     # using `field` instead of `configure` will exclude all other fields and force the ordering
  # end

end
