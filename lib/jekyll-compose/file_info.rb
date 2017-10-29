class Jekyll::Compose::FileInfo
  attr_reader :params, :extra_params

  def initialize(params, extra_params = {})
    @params = params
    @extra_params = extra_params
  end

  def name
    Jekyll::Utils.slugify params.title
  end

  def file_name
    "#{name}.#{params.type}"
  end

  def image_folder
    nil
  end

  def file_content
    ''
  end

  def content
    front_matter = YAML.dump({
      "layout" => params.layout,
      "title"  => params.title,
    }.merge(extra_params))

    front_matter + "---\n" + file_content
  end
end
