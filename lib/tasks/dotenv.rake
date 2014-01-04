namespace :dev do
  desc 'Initialize development environment configuration'
  task dotenv: [:environment] do
    unless Rails.env.development? || Rails.env.test?
      abort "can only be run in development or test"
    end

    template = File.join(Rails.root, '.env.erb')
    target = File.join(Rails.root, '.env')

    File.open(target, 'w') do |dotenv|
      dotenv.write ERB.new(File.read(template)).result(binding)
    end
  end
end
