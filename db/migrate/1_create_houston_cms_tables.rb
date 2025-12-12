class CreateHoustonCmsTables < ActiveRecord::Migration[4.2]
  def change
    create_table :snippets do |t|
      t.string :name
      t.string :slug
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

   
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.string :slug
      t.text :description
      t.boolean :show_title
      t.string :template
      t.text :banner_text
      t.boolean :published

      t.timestamps
    end
   

    create_table :blockcontents do |t|
      t.text :content
      t.timestamps
    end

    create_table :blockmediasets do |t|
      t.string :title
      t.text :body
      t.string :link
      t.string :direction
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.integer :image_columns, default: 5
      t.string :image_style, default: "bordered"
    end

    create_table :sections do |t|
      t.string :name
      t.string :template
      t.string :title
      t.text :style
      t.integer :position
      t.integer :sectionable_id
      t.string :sectionable_type
      t.boolean :show_title, default: false, null: false
      t.integer :sectiontypeable_id
      t.string :sectiontypeable_type

      t.timestamps
    end

    add_index :sections, [ :sectionable_type, :sectionable_id ]
    add_index :sections, [ :sectiontypeable_type, :sectiontypeable_id ]

    create_table :menus do |t|
      t.string :name
      t.text :description
      t.timestamps
    end

    create_table :menuitems do |t|
      t.string :name
      t.integer :menu_id, null: false
      t.integer :position
      t.string :link
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string :ancestry
      t.integer :ancestry_depth, default: 0
      t.integer :children_count, default: 0
      t.integer :menuitemable_id
      t.string :menuitemable_type
      t.string :style
      t.string :strap

      t.index :ancestry
      t.index :menu_id
      t.index [ :menuitemable_type, :menuitemable_id ]
    end


    create_table :media do |t|
      t.string :name
      t.string :title
      t.text :alt
      

      t.timestamps
    end

  end
end