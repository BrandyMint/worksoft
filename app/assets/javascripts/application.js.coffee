#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require jquery_nested_form
#= require jquery.freetile.min

$ ->
  $('[rel*="freetile-container"]').each ->
    target = $(this).attr('data-target')
    if target && target.length > 0
      $(this).freetile({ selector: target })
    else
      $(this).freetile()
