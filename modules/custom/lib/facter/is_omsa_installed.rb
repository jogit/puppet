# is_omsa_installed.rb

Facter.add("is_omsa_installed") do
  setcode do
        if FileTest.exists?("/etc/init.d/dataeng")
                'true'
        else
                'false'
        end
  end
end

