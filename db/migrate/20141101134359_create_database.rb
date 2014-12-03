class CreateDatabase < ActiveRecord::Migration
  def up
    create_table :brews do |t|
      t.string :name
      t.string :category
      t.integer :ontap
      t.string :color
      t.integer :medals
      t.integer :soldout
      t.string :abv
      t.string :ibu
      t.string :glass
      t.string :growler
  end
  Brew.create(name: "Placeholder Pils",
                category: "signature",
                ontap: 0,
                color: "#ffffff",
                medals: 1,
                soldout: 1,
                abv: "0.0",
                ibu: "0.0",
                glass: "4.00",
                growler: "11.50")
  end
  def down
    drop_table :brews
  end
end
