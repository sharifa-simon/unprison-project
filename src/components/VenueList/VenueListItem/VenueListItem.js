import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router';
//styling imports
import { TableCell, TableRow } from '@material-ui/core';
import Button from '@material-ui/core/Button';

class VenueListItem extends Component {

    goToVenueDetails = () => {
        this.props.history.push(`/venue-details/${this.props.venue.id}`)
    }

    render() {
        return (

            <TableRow id="TableRow">
                <TableCell >{this.props.venue.name}</TableCell >
                <TableCell >{this.props.venue.contact_name_one}</TableCell >
                <TableCell >{this.props.venue.contact_phone_one}</TableCell >
                <TableCell align="right"><Button variant="outlined" size="small" color="primary" onClick={this.goToVenueDetails}>Details</Button></TableCell>
            </TableRow>

        );
    }
}

// Provides component access to reduxState through props
const mapStateToProps = reduxState => ({
    reduxState,
});

export default withRouter(connect(mapStateToProps)(VenueListItem));