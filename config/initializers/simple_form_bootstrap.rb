%w[
  CollectionSelectInput
  DateTimeInput
  FileInput
  GroupedCollectionSelectInput
  NumericInput
  PasswordInput
  RangeInput
  StringInput
  TextInput
].each do |klass|
  "SimpleForm::Inputs::#{klass}".constantize.class_eval do
    def input_html_classes
      super.push('form-control')
    end
  end
end

SimpleForm.setup do |config|
  config.wrappers :bootstrap, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder

    b.use :label
    b.use :input
    b.use :error, wrap_with: { tag: 'div', class: 'help-inline text-danger' }
    b.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
  end

  config.wrappers :group, tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.wrapper tag: 'div', class: 'controls' do |input|
      input.wrapper tag: 'div', class: 'input-group' do |group|
        group.use :input
      end
      input.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
      input.use :error, wrap_with: { tag: 'span', class: 'help-inline text-danger' }
    end
  end

  config.default_wrapper = :bootstrap
  config.error_notification_class = 'alert alert-danger'
end
