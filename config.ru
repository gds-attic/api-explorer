use Rack::Static, 
  :urls => ["/css", "/img", "/js"],
  :root => "public"

run lambda { |env|
  request = Rack::Request.new(env)
  if request.path.match(/^\/api\/(.*)/)
    body = open("https://www.gov.uk/#{$1}")
  else
    body = File.open('public/index.html', File::RDONLY)
  end

  [
    200, 
    {
      'Content-Type'  => 'text/html', 
      'Cache-Control' => 'public, max-age=86400' 
    },
    body
  ]
}