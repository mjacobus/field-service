server 'demo.fs.dev',
  roles: %w{web},
  ssh_options: {
    auth_methods: %w(publickey),
    user: 'rails',
  }
