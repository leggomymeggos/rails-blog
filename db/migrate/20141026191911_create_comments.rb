class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string     :commenter
      t.text       :body

      # this is the same as 't.integer  :article_id'
      t.references :article, index: true

      t.timestamps
    end
  end
end
