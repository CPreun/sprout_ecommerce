$(document).ready(function() {
    $('#plant_category_select').change(function() {
        var category_id = $(this).val();
        $.ajax({
            url: '/admin/subcategories?category_id=' + category_id,
            type: 'GET',
            success: function(data) {
                var subcategorySelect = $('#plant_subcategory_select');
                subcategorySelect.empty();
                subcategorySelect.append('<option value="">Select Subcategory</option>');
                $.each(data, function(index, subcategory) {
                    subcategorySelect.append('<option value="' + subcategory.id + '">' + subcategory.name + '</option>');
                });
            }
        });
    });
});