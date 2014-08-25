$ ->
  $(document).on "change", ".edit_todo_from_index input[type=checkbox]", ->
    $(this).parent(".edit_todo_from_index").submit()
    $(this).prop("disabled", true)

  $(document).on("ajax:success", ".edit_todo_from_index", (e, data, status, xhr) ->
    $("#flash").append '<div data-alert class="alert-box ' + data.status + '">' + data.message + '<a href="#" class="close">&times;</a></div>'
    if data.todo.completed
      $("#edit_todo_" + data.todo.id.toString()).addClass('completed').fadeOut "slow", ->
        $(this).remove()
    else
      $("input[type=checkbox]", this).removeProp("disabled")
  ).on "ajax:error", ".edit_todo_from_index", (e, xhr, status, error) ->
    $("#flash").append '<div data-alert class="alert-box alert">' + xhr.responseText + '<a href="#" class="close">&times;</a></div>'
    $("input[type=checkbox]", this).removeProp("disabled")

  $(document).on "submit", "#new_todo", ->
    $("button", this).prop("disabled", true)

  $(document).on("ajax:success", "#new_todo", (e, data, status, xhr) ->
    $("#flash").append '<div data-alert class="alert-box success">To-do created successfully.<a href="#" class="close">&times;</a></div>'
    $("#todos").append xhr.responseText
    this.reset()
    $("button", this).removeProp("disabled")
  ).on "ajax:error", "#new_todo", (e, xhr, status, error) ->
    $("#flash").append '<div data-alert class="alert-box alert">To-do could not be created.<a href="#" class="close">&times;</a></div>'
    $("button", this).removeProp("disabled")
