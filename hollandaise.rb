Hollandaise.project "cats" do |p|
  p.root 'http://my.site/'

  p.screenshot 'Home', '/'
  p.screenshot 'Archive', '/archive'

  p.browsers :chrome
end

