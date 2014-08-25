$ ->
  # Submit when a to-do's checkbox is checked
  $(document).on "change", ".edit_todo_from_index input[type=checkbox]", ->
    $(this).parents(".edit_todo_from_index").submit()
    $(this).prop("disabled", true)

  # Remove to-dos marked as completed via AJAX
  $(document).on("ajax:success", ".edit_todo_from_index", (e, data, status, xhr) ->
    $("#flash").append('<div data-alert class="alert-box ' + data.status + '"><div>' + data.message + '</div><a href="#" class="close">&times;</a></div>').foundation("alert", undefined)
    if data.todo.completed
      $("#edit_todo_" + data.todo.id.toString()).addClass('completed').fadeOut "slow", ->
        $(this).remove()
    else
      $("input[type=checkbox]", this).removeProp("disabled")
  ).on "ajax:error", ".edit_todo_from_index", (e, xhr, status, error) ->
    $("#flash").append('<div data-alert class="alert-box alert"><div>' + xhr.responseText + '</div><a href="#" class="close">&times;</a></div>').foundation("alert", undefined)
    $("input[type=checkbox]", this).removeProp("disabled")

  # Disable the new to-do form's submit button while submitting
  $(document).on "submit", "#new_todo", ->
    $("button", this).prop("disabled", true)

  # Add new to-dos created via AJAX to the list and reset the form
  $(document).on("ajax:success", "#new_todo", (e, data, status, xhr) ->
    $("#flash").append('<div data-alert class="alert-box success"><div>To-do created successfully.</div><a href="#" class="close">&times;</a></div>').foundation("alert", undefined)
    $("#todos").append xhr.responseText
    this.reset()
    $("button", this).removeProp("disabled")
  ).on "ajax:error", "#new_todo", (e, xhr, status, error) ->
    $("#flash").append('<div data-alert class="alert-box alert"><div>To-do could not be created.</div><a href="#" class="close">&times;</a></div>').foundation("alert", undefined)
    $("button", this).removeProp("disabled")
