$ ->
  return unless $(".registration").length > 0

  Eventbrite 'app_key': "RZQXZEESDHF3735ALY", 'user_key': "137165904265007877311", (eb_client) ->
    eb_client.event_get 'id': 3210614033, (response) ->
      $.each response.event.tickets, (index, ticket) ->
        ticket_element = $("<tr id='ticket-#{ticket.ticket.id}'>
                              <td class='name'></td>
                              <td class='quantity-available'></td>
                              <td class='price'></td>
                              <td class='quantity-selected'>
                                <select name='quant_#{ticket.ticket.id}'></select>
                              </td>
                            </tr>")

        if ticket.ticket.name.match(/^Conference Pass with /)
          $("table#excursions").append(ticket_element)
        else if ticket.ticket.name.match(/^AM Workshop: /)
          $("table#am-workshops").append(ticket_element)
        else if ticket.ticket.name.match(/^PM Workshop: /)
          $("table#pm-workshops").append(ticket_element)

        name = ticket.ticket.name.replace(/^Conference Pass with /, '')
        name = name.replace(/^AM Workshop: /, '')
        name = name.replace(/^PM Workshop: /, '')

        $("#ticket-#{ticket.ticket.id} .name").text(name)
        $("#ticket-#{ticket.ticket.id} .price").text("$#{Math.round(ticket.ticket.price)}")

        option_element = $("<option value='0'>0</option>")
        $("#ticket-#{ticket.ticket.id} .quantity-selected select").append(option_element)
        max = Math.min(ticket.ticket.max, ticket.ticket.quantity_available)
        for n in [ticket.ticket.min..max]
          option_element = $("<option value='#{n}'>#{n}</option>")
          $("#ticket-#{ticket.ticket.id} .quantity-selected select").append(option_element)

        if ticket.ticket.quantity_available <= 0
          $("#ticket-#{ticket.ticket.id} .quantity-available").html("<span class='sold-out'>Sold Out</span>")
          $("#ticket-#{ticket.ticket.id} .quantity-selected select").attr("disabled", "disabled")
        else
          $("#ticket-#{ticket.ticket.id} .quantity-available").text(
            "#{ticket.ticket.quantity_available} #{owl.pluralize('Ticket', ticket.ticket.quantity_available)}"
          )
