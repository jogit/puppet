# is_proxmox.rb

Facter.add("is_proxmox") do
  setcode do
        if FileTest.exists?("/usr/bin/pveversion")
                "true"
        else
                "false"
        end
  end
end

