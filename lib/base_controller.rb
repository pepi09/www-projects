class BaseController
  def initialize(params: {})
    @params = params
  end

  private

  attr_accessor :params

  def render(view_path)
    view_content = File.read("./views/#{view_path}.html.erb")
    ERB.new(view_content).result(binding)
  end
end
