$ ->
  $(".edit_todo_from_index input[type=checkbox]").on "change", ->
    $(this).parent(".edit_todo_from_index").submit()
    $(this).prop("disabled", true)

  $(".edit_todo_from_index").on("ajax:success", (e, data, status, xhr) ->
    $("#flash").append '<div data-alert class="alert-box ' + data.status + '">' + data.message + '<a href="#" class="close">&times;</a></div>'
    if data.todo.completed
      $("#edit_todo_" + data.todo.id.toString()).addClass('completed').fadeOut "slow", ->
        $(this).remove()
    else
      $("input[type=checkbox]", this).removeProp("disabled")
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#flash").append '<div data-alert class="alert-box alert">' + xhr.responseText + '<a href="#" class="close">&times;</a></div>'
    $("input[type=checkbox]", this).removeProp("disabled")
