class AddItemToItemMaterials < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :item_material, index: true, foreign_key: { on_delete: :cascade }
  end
end
