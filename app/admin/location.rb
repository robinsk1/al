ActiveAdmin.register Location do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :name, :description, photos_attributes: [:image]

 index do
   selectable_column
   id_column
   column :name
   column :description
   actions
 end

 show do
   h3 location.name
   div do
     simple_format location.description
   end
   location.photos.each do |photo|
     div do
       image_tag photo.image.url
     end
   end
 end

 form do |f|
   f.semantic_errors(*f.object.errors.keys)
   f.inputs do
     f.input :name
     f.input :description
     f.inputs "Photo", :multipart => true do
       f.has_many :photos, heading: 'Photos', allow_destroy: true do |a|
         a.input :image, :as => :file, :hint => image_tag(a.object.image.url)
       end
     end
   end

   f.actions
 end

end