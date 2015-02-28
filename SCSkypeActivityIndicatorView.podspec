Pod::Spec.new do |s|
  s.name     = 'SCSkypeActivityIndicatorView'
  s.version  = '1.0.0'
  s.platform = :ios
  s.ios.deployment_target = '5.0'

  s.summary  = 'Activity indicator view similar to the one seen in the Skype apps.'
  s.description = <<-DESC
                  SCSkypeActivityIndicatorView is an activity indicator view similar to the one seen in the Skype apps.
                  DESC
  s.homepage = 'https://github.com/stefanceriu/SCSkypeActivityIndicatorView'
  s.author   = { 'Stefan Ceriu' => 'stefan.ceriu@yahoo.com' }
  s.social_media_url = 'https://twitter.com/stefanceriu'
  s.source   = { :git => 'https://github.com/stefanceriu/SCSkypeActivityIndicatorView.git', :tag => "v#{s.version}" }
  s.license      = { :type => 'MIT License', :file => 'LICENSE' }
  s.source_files = 'SCSkypeActivityIndicatorView/*'
  s.requires_arc = true
  s.frameworks = 'UIKit', 'QuartzCore', 'CoreGraphics', 'Foundation'
  s.screenshots = ["https://dl.dropboxusercontent.com/u/12748201/SCSkypeActivityIndicatorView/SCSkypeActivityIndicatorView1.gif"]

end