class Basic < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text    :lurl,      null: false
      t.string  :hash_md5,  null: false, index: true
      t.string  :hash_sha1, null: false, index: true
    end
  end
end
