$(function(){

    $(document).on('change', 'input[name=domain]', function(){
        console.log(this.value.match(/\.$/));
        if (this.value.match(/\.$/)) {
            $("#err").html('');
        } else {
            $("#err").html('append . to domain. ex: example.com.');
        }
    });

    var mx_ext_tag;
    $(document).on('change', '#type', function() {
        if(this.value == "MX") {
            mx_ext_tag = ['<label for="priority" class="ext">Priprity</label>',
                          '<input type="text" name="priority" class="ext" required="required">'].join("\n");
            $(this).after(mx_ext_tag);
        }
        else {
            $('.ext').remove();
        }
    });
});
