class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: { name: 'fk_comments_author_id' }
      t.references :post, foreign_key: { name: 'fk_comments_post_id' }
      t.text :text

      t.timestamps
    end
  end
end