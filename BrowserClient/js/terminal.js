$(function() {
  $('#terminal').terminal(function(command, term) {
    var args = command.split(' ');
    var url = 'cmd?command=';
    var command = '';
    for (i in args) {
      if (i == 0) {
        url += args[i];
        command = args[i];
      } else {
        url += '&' + args[i];
      }
    }

    if (command == 'download') {
      $.ajax({
        url: url,
        type: 'post',
        processData: false
      });
      return;
    }

    term.echo('Loading', {
      raw: true,
      finalize: function(div) {
        div.attr('id', 'loadingLabel');
      }});
    $.ajax({
      url: url,
      success: function(data) {
        switch (command) {
          case 'list':
            handleListResponse(data, term);
            break;
          case 'find':
            handleFindResponse(data, term);
            break;
          case 'parse':
            term.echo('done');
            break;
          case 'backtrace':
            handleBacktraceResponse(data, term);
            break;
          case 'argtrace':
            handleArgtraceResponse(data, term);
            break;
          case 'called':
            handleCalledResponse(data, term);
            break;
          case 'config':
            term.echo(data);
            break;
          case 'download':
            term.echo(data);
            break;
          default:
            term.echo('Unknown command');
            break;
        }
        $('#loadingLabel').remove();
        $(window).scrollTop($(document).height());
      },
      error: function() {
        $('#loadingLabel').remove();
        term.echo("Error");
      }
    });
  })
});


function handleListResponse(responseData, term) {
  var list = $.parseJSON(responseData);

  for (i in list) {
    term.echo(list[i].class + ' ' + list[i].method, {finalize: formatOutpu});
  }
}

function handleFindResponse(responseData, term) {
  var list = $.parseJSON(responseData);

  for (i in list) {
    printCall(list[i], term);

  }
}

function handleBacktraceResponse(responseData, term) {
  var backtraces = $.parseJSON(responseData);

  for (i in backtraces) {
    term.echo('Backtrace:');
    for (j in backtraces[i]) {
      printCall(backtraces[i][j], term);
      printPadding(term);
    }
    term.echo(' ');
  }
  //TODO
}

function handleArgtraceResponse(responseData, term) {
  var traces = $.parseJSON(responseData);

  for (i in traces) {
    term.echo('Trace: ');
    for (j in traces[i]) {
      printCall(traces[i][j], term);
    }
    printPadding(term);
  }
}

function handleCalledResponse(responseData, term) {
  var calls = $.parseJSON(responseData);

  for (i in calls) {
    printCall(calls[i], term);
  }
}

function printCall(call, term) {
  term.echo(call.class + ' ' + call.method + ' (ID: ' + call.callID + ', called by: ' + call.callerID + '): ' + call.self, {finalize: formatOutpu});
  var returnString = '\tReturn: ' + call.returnType + ' ' + call.returnValue;
  if (call.returnDescription) {
    returnString += ': ' + call.returnDescription;
  }
  term.echo(returnString, {finalize: formatOutpu});

  for (j in call.arguments) {
    var arg = call.arguments[j];
    var argumentString = arg.type + ' ' + arg.value;
    if (arg.description) {
      argumentString += ': ' + arg.description;
    }
    term.echo('\t' + argumentString, {finalize: formatOutpu});
  }
}

function printPadding(term) {
  term.echo('<div></div>', {
    raw: true,
    finalize: function(div) {
      $(div).addClass('terminalPadding');
    }
  });
}

function formatOutpu(div) {
  $(div).addClass('terminalOutput')
}
