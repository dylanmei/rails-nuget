Nuget::Application.routes.draw do
	def api
    package_constraints = { :package_id => /[^\/]*/, :version => /[^\/]*/ }

		scope '/package' do
			put '' => 'packages#create'
			delete ':package_id/:version' => 'packages#delete', :constraints => package_constraints
			get ':package_id/:version' => 'packages#show', :constraints => package_constraints
		end

    scope '/packages' do
      get ':metadata' => 'packages#metadata', :constraints => { :metadata => /\$metadata/ }
      get '' => 'packages#index', :defaults => { :format => 'xml' }, :as => :packages
      get ':area' => 'packages#index', :defaults => { :format => 'xml' },
          :constraints => { :area => /.*/ }
    end

		put '' => 'packages#create'
		get ':package_id/:version' => 'packages#show', :constraints => package_constraints
		delete ':package_id/:version' => 'packages#delete', :constraints => package_constraints
	end

	scope '/api' do
		scope '/v2' do
			api
		end
	end

	root :to => 'home#index'
end
