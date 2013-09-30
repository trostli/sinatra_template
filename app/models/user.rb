class User < ActiveRecord::Base
   has_many :playlists

    def self.from_auth_hash(auth_hash)
      user = User.find_or_create_by(facebook_id: auth_hash[:id])
      user.update_attributes(full_name: auth_hash.fetch(:info, {}).fetch(:name, ""))
      user
  end
end
