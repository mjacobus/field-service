server fetch(:application),
       user: 'deploy',
       roles: %w[web app db mysql_dump],
       ssh_options: {
         user: 'deploy', # overrides user setting above
         # keys: %w(/home/user_name/.ssh/id_rsa),
         forward_agent: true,
         auth_methods: %w[publickey password]
         # password: "please use keys"
       }
