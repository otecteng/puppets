class china{
  file { "/root/gem_tb.sh":
    owner => "root",
    mode  => "775",
    content => "gem sources -r http://rubygems.org/
gem sources -a http://ruby.taobao.org/",
  }->
  exec{ "change gem":
    command => "/bin/bash /root/gem_tb.sh",
  }
}
class rails($china=false) {
  package{["mongodb","nodejs","nginx","redis-server","make","ruby-dev"]:
    ensure=>"installed",
  }->
  file{ "/etc/nginx/nginx.conf":
    owner => "root",
    mode  => "775",
    source => "puppet:///modules/rails/nginx.conf",
  }
  if($china){
    require china
  }
  package{["rails"]:
    ensure=>"3.2.19",
    provider=>"gem"
  }->
  package{["sidekiq","unicorn"]:
    ensure=>"installed",
    provider=>"gem"
  }
}

