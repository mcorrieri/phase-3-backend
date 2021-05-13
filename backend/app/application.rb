class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/test/) 
      return [200, { 'Content-Type' => 'application/json' }, [ {:message => "test response!"}.to_json ]]

    elsif req.path == "/statevaccine" && req.get?
      body = Statevaccine.national_data
      return [200, { 'Content-Type' => 'application/json' }, [ body.to_json ]]

    elsif req.path == "/nationalchart" && req.get?
      body = Statevaccine.national_chart
      return [200, { 'Content-Type' => 'application/json' }, [ body.to_json ]]


    else
      resp.write "Path Not Found"

    end

    resp.finish
  end

end
