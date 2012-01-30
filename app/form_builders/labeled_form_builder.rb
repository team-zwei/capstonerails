class LabeledFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :tag, to: :@template
  
  %w[text_field text_area password_field].each do |method_name|
    define_method(method_name) do |name, *args|
      content_tag :div, class: "field" do
        field_label(name, *args) + super(name, *args)
      end
    end
  end
  
  def submit(*args)
    content_tag :div, class: "actions" do
      super
    end
  end
  
  def error_messages
    if object.errors.full_messages.any?
      content_tag(:div, :class => "error_messages") do
        content_tag(:h2, "Invalid Fields") +
        content_tag(:ul) do
          object.errors.full_messages.map do |msg|
            content_tag(:li, msg)
          end.join.html_safe
        end
      end
    end
  end
  
private

  def field_label(name, *args)
    options = args.extract_options!
    required = object.class.validators_on(name).any? { |v| v.kind_of? ActiveModel::Validations::PresenceValidator }
    label(name, options[:label], class: ("required" if required))
  end
  
  def objectify_options(options)
    super.except(:label)
  end
end