class rails {
  file { "/root/gem_tb.sh":
    owner => "root",
    mode  => "775",
    content => "gem sources -r http://rubygems.org/
gem sources -a http://ruby.taobao.org/",
  }->
  exec{ "add gem":
    command => "/bin/bash /root/gem_tb.sh",
  }->
  package{["mongodb","nodejs","nginx","redis-server","make","ruby-dev"]:
    ensure=>"installed",
  }->
  package{["rails"]:
    ensure=>"3.2.19",
    provider=>"gem"
  }->
  package{["sidekiq","unicorn"]:
    ensure=>"installed",
    provider=>"gem"
  }->
  file { "/etc/nginx/nginx.conf":
    owner => "root",
    mode  => "775",
    source => "puppet:///modules/rails/nginx.conf",
  }
}
