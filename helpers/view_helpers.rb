
helpers do

  def tag(tag, content, params={})
    options = params.collect{|key, val| "#{key}='#{val}'" }.join(' ')
    "<#{tag} #{options}>#{content}</#{tag}>"
  end

  def script(js_code)
    "<script type='text/javascript'>#{js_code}</script>"
  end

  def alert(clazz, message)
    button_html = '<button type="button" class="close" data-dismiss="alert">&times;</button>'
    tag('div', button_html+message, :class => "alert alert-dismissable alert-#{clazz}")
  end

  def activate_tab(tab_href)
    script "$(function () { $(\"[href='##{tab_href}']\").tab('show') })"
  end

end