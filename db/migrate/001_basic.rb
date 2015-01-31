class Basic < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.text    :long_url,              null: false
      t.column  :hash_md5,  "char(32)", null: false, index: true
      t.column  :hash_sha1, "char(40)", null: false, index: true
      t.timestamps
    end
  end
end
